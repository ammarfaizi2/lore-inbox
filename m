Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268125AbRGWCRN>; Sun, 22 Jul 2001 22:17:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268126AbRGWCRD>; Sun, 22 Jul 2001 22:17:03 -0400
Received: from hinako.ambusiness.com ([64.59.51.7]:41222 "EHLO
	Hinako.AMBusiness.com") by vger.kernel.org with ESMTP
	id <S268125AbRGWCQs>; Sun, 22 Jul 2001 22:16:48 -0400
Message-ID: <010201c1131d$7359d150$9865fea9@optima>
From: "Anthony Barbachan" <barbacha@Hinako.AMBusiness.com>
To: "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>
Subject: Question on porting 2.2.x driver to 2.4.x (reference namei)
Date: Sun, 22 Jul 2001 22:16:14 -0400
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 5.50.4522.1200
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4522.1200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing

Hi all,

    I'm trying to port iBCS to the 2.4.x kernels.  One of the compile
problems I've run into is that the 2.4.x kernel includes lack a namei()
function definition.  I figure this function has been removed however what
is its replacement?  Or at least how do I replace its functionality?  The
section of code in iBCS in which this is used looks like this:

dentry = namei(path);
error = PTR_ERR(dentry);

if (!IS_ERR(dentry)) {


Thanks in advance for any help.

