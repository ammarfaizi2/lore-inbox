Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263182AbVFXSjJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263182AbVFXSjJ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Jun 2005 14:39:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263176AbVFXSio
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Jun 2005 14:38:44 -0400
Received: from build.arklinux.osuosl.org ([140.211.166.26]:64685 "EHLO
	mail.arklinux.org") by vger.kernel.org with ESMTP id S263182AbVFXSfA
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Jun 2005 14:35:00 -0400
From: Bernhard Rosenkraenzer <bero@arklinux.org>
Organization: Ark Linux team
To: linux-kernel@vger.kernel.org
Subject: 2.6.12-mm1 keyboard oddities
Date: Fri, 24 Jun 2005 20:35:18 +0200
User-Agent: KMail/1.8.1
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200506242035.18902.bero@arklinux.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
after applying Dipankar Sarma's patch for the fcntl64 Oops, 2.6.12-mm1 works 
nicely here (x86). One oddity: If I don't "loadkeys anything", only the very 
basic keys work, all F* keys etc. are dead.

Is this an intentional change to force people to do the right thing and load 
some keymap, or a bug?
