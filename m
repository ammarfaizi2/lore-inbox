Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261475AbVBAAaw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261475AbVBAAaw (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 31 Jan 2005 19:30:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261468AbVBAA2K
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 31 Jan 2005 19:28:10 -0500
Received: from quechua.inka.de ([193.197.184.2]:32731 "EHLO mail.inka.de")
	by vger.kernel.org with ESMTP id S261501AbVBAAH3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 31 Jan 2005 19:07:29 -0500
From: Bernd Eckenfels <ecki-news2005-01@lina.inka.de>
To: linux-kernel@vger.kernel.org
Subject: Re: [RFC] "biological parent" pid
Organization: Deban GNU/Linux Homesite
In-Reply-To: <Pine.LNX.4.53.0501311923440.18039@gockel.physik3.uni-rostock.de>
X-Newsgroups: ka.lists.linux.kernel
User-Agent: tin/1.7.6-20040906 ("Baleshare") (UNIX) (Linux/2.6.8.1 (i686))
Message-Id: <E1CvlZk-0007D3-00@calista.eckenfels.6bone.ka-ip.net>
Date: Tue, 01 Feb 2005 01:07:24 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <Pine.LNX.4.53.0501311923440.18039@gockel.physik3.uni-rostock.de> you wrote:
> I am not aware of concepts in Linux or other unices that apply to this
> case.

Normal process accounting.

If you want to keep the pid of the bio-parent, you also need to keep the
start-time to make it unique. Better would be to have a all-time-unqiue
process handle. But I think it is better to not have that field, but use
audit logs. That is especially needed if you want to track chains, because
it doesnt help you to know the bio parent if you have no idea what that was.

Gruss
Bernd
