Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932257AbVHMTFG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932257AbVHMTFG (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 13 Aug 2005 15:05:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932258AbVHMTFG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 13 Aug 2005 15:05:06 -0400
Received: from wproxy.gmail.com ([64.233.184.207]:20641 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932257AbVHMTFE convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 13 Aug 2005 15:05:04 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=uOe5S75K/huxUyiHuPX0fRNH6S/Z7j7Wr3RTPfbMaQw1bnQqTHQ6zTgN6sBznG9HQ95910pVIKHDEDAgAQRbFNMryBzmekMSwyUm1b9qThg5PPIuDqK4VFvo6ne/ZY471K1yMdn7rKBIRaPYk5h2LvFFDAkYUV+wRLLR565NhOc=
Message-ID: <4fec73ca05081312054f1d1dd9@mail.gmail.com>
Date: Sat, 13 Aug 2005 21:05:03 +0200
From: =?ISO-8859-1?Q?Guillermo_L=F3pez_Alejos?= <glalejos@gmail.com>
To: Linux Kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Documenting the VFS
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I'm writing documentation about the VFS. More concretely, I want to
document the following information about the methods defined in the
VFS interface (i.e. the struct *_operations):
    - Prototype.
    - Description (brief description of what the method has to do).
    - Description of the parameters (explanation of the purpose of
each parameter).
    - Return value (including possible error values).
    - Responsibility (what the method is expected to do, including
specific cases).
    - Default method (is there any method that can be used instead of
defining a new one?)
    - Mandatory (Is the method mandatory? or it can be assigned a NULL?)

It is rather difficult to find this information by looking at the
kernel sources, and the documentation I have found does not provide
the details I'm looking for.

Where can I found an up to date documentation about the VFS interface?
If there is no such document, which is the correct mailing list to
submit my questions at? Is there any IRC channel to chat about this?
(I have visited a couple of times #kernelnewbies).

Thanks for your help and regards,

-- 
Guillermo
