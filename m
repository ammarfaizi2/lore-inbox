Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932480AbWCFXxX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932480AbWCFXxX (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Mar 2006 18:53:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752469AbWCFXxD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Mar 2006 18:53:03 -0500
Received: from e34.co.us.ibm.com ([32.97.110.152]:60567 "EHLO
	e34.co.us.ibm.com") by vger.kernel.org with ESMTP id S1752052AbWCFXxA
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Mar 2006 18:53:00 -0500
Subject: [RFC][PATCH 0/6] support separate namespaces for sysv
To: linux-kernel@vger.kernel.org
Cc: serue@us.ibm.com, frankeh@watson.ibm.com, clg@fr.ibm.com,
       Herbert Poetzl <herbert@13thfloor.at>, Sam Vilain <sam@vilain.net>,
       Dave Hansen <haveblue@us.ibm.com>
From: Dave Hansen <haveblue@us.ibm.com>
Date: Mon, 06 Mar 2006 15:52:48 -0800
Message-Id: <20060306235248.20842700@localhost.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is more followup on this thread:

http://marc.theaimsgroup.com/?l=linux-kernel&m=114108773827517&w=2

The following series makes it possible to isolate different
sets of sysv structures (msg, sem, and shm) on one kernel.

The initial patch makes it much more feasible to access these
disparite sets from the traditional sysctl interfaces.
