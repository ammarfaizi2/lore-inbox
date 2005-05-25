Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262344AbVEYPdP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262344AbVEYPdP (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 May 2005 11:33:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262375AbVEYPdP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 May 2005 11:33:15 -0400
Received: from igw2.watson.ibm.com ([129.34.20.6]:35207 "EHLO
	igw2.watson.ibm.com") by vger.kernel.org with ESMTP id S262344AbVEYPdL
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 May 2005 11:33:11 -0400
Date: Wed, 25 May 2005 11:32:57 -0400 (Eastern Daylight Time)
From: Reiner Sailer <sailer@us.ibm.com>
To: Pavel Machek <pavel@ucw.cz>
cc: Emilyr@us.ibm.com, James Morris <jmorris@redhat.com>, Kylene@us.ibm.com,
       linux-kernel@vger.kernel.org, linux-security-module@wirex.com,
       Toml@us.ibm.com, Valdis.Kletnieks@vt.edu
Subject: Re: [PATCH 2 of 4] ima: related Makefile compile order change and
 Readme
Message-ID: <Pine.WNT.4.63.0505251116180.3308@laptop>
X-Warning: UNAuthenticated Sender
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Pavel Machek <pavel@ucw.cz> wrote on 05/25/2005 11:06:01 AM:

> > 
> > If I understand you, then you are claiming that steps (ii) to (v) 
> > introduce buffer overflows in bash or show_etc_issue. How?
> 
> No, I'm not claiming that. You are certainly *not* introducing any new
> problems.
> 
> But some problems that used to be harmless (buffer overrun in
> show_etc_issue command) are not harmless any more.
>                         Pavel

How is a buffer overrun in a script/application less "harmless" with IMA? 
Please be specific. Preliminary IMA patches are out on the mailing lists.

The only thing that IMA does with respect to existing known buffer 
overruns is that it enables remote parties to know that there is an application 
with a known buffer overrun if this application/script was measured. Such 
information is sensitive and this is one reason why direct access to the 
measurements are restricted to authorized/trusted parties.

Thanks
Reiner

