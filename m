Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262679AbTJJAHm (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Oct 2003 20:07:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262680AbTJJAHm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Oct 2003 20:07:42 -0400
Received: from cmu-24-35-14-252.mivlmd.cablespeed.com ([24.35.14.252]:30879
	"EHLO localhost.localdomain") by vger.kernel.org with ESMTP
	id S262679AbTJJAHm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Oct 2003 20:07:42 -0400
Date: Thu, 9 Oct 2003 20:07:38 -0400 (EDT)
From: Thomas Molina <tmolina@cablespeed.com>
X-X-Sender: tmolina@localhost.localdomain
To: linux-kernel@vger.kernel.org
Subject: [Bug 973] 2.6.0-test7 oops in store_stackinfo
Message-ID: <Pine.LNX.4.44.0310091953400.12708-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Please see bugzilla number 973 for the gory details.  The problem remains 
through Linus' stability release.  Short summary is that if both 
CONFIG_DEBUG_SLAG and CONFIG_DEBUG_PAGEALLOC are defined I get a 
repeatable oops in store_stackinfo.  If one or the other is not defined 
the oops doesn't happen.

