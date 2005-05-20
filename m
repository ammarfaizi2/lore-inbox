Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261555AbVETTMP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261555AbVETTMP (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 May 2005 15:12:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261558AbVETTMP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 May 2005 15:12:15 -0400
Received: from smtpauth.newman.easystreet.com ([206.102.12.11]:30842 "EHLO
	smtpauth.easystreet.com") by vger.kernel.org with ESMTP
	id S261555AbVETTMM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 May 2005 15:12:12 -0400
From: "ted creedon" <tcreedon@easystreet.com>
Cc: <openafs-info@openafs.org>, <linux-kernel@vger.kernel.org>
Subject: RE: [OpenAFS] Re: Openafs 1.3.78 and kernel 2.4.29 oopses , same for 2.4.30 and openafs 1.3.82
Date: Fri, 20 May 2005 12:12:05 -0700
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Office Outlook, Build 11.0.6353
Thread-Index: AcVdbVPgEVCf+oASS3a/Od5jLQOkMQAATNqQ
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.2180
In-Reply-To: <Pine.LNX.4.62.0505202152200.3235@tassadar.physics.auth.gr>
Message-Id: <20050520191207.15E3D29528@smtpauth.easystreet.com>
To: unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Gcc -dumpmachine  #should prints out i586-suse-linux for a P III here.

I'd try a fresh single processor machine and force a 2.6 kernel, module and
afs recompile for a i586.

SuSE 9.3 costs $90 and it solved a similar problem noted in the mailings. In
fact the YasT installed openafs binaries ran fine.

The ksymoops man page has a script to tail -f /var/log/messages|ksymoops1
explained.

Are you sure there isn't a memory problem? I'm running out of ideas.
tedc

