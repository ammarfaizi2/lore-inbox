Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267208AbTAPSwW>; Thu, 16 Jan 2003 13:52:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267200AbTAPSvd>; Thu, 16 Jan 2003 13:51:33 -0500
Received: from [207.236.123.4] ([207.236.123.4]:27877 "EHLO mail.oerlikon.ca")
	by vger.kernel.org with ESMTP id <S267199AbTAPSug> convert rfc822-to-8bit;
	Thu, 16 Jan 2003 13:50:36 -0500
Content-Type: text/plain;
  charset="us-ascii"
From: Jeroen van Disseldorp <jdizzl@xs4all.nl>
Organization: Cap Gemini Ernst & Young
To: linux-kernel@vger.kernel.org
Subject: Detecting changes in a directory tree
Date: Thu, 16 Jan 2003 13:58:36 -0500
User-Agent: KMail/1.4.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
Message-Id: <200301161358.36497.jdizzl@xs4all.nl>
X-OriginalArrivalTime: 16 Jan 2003 18:59:32.0054 (UTC) FILETIME=[6748FF60:01C2BD91]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

For an application I'm writing I need to know if files in a certain 
directory tree were modified and/or deleted by another process. I 
assume that that tree is mounted on the machine that my app is running 
on. The device it has mounted on can be a local HD, but it can also be 
hosted remotely and mounted over nfs.

I know of FAM, but this is documented to only watch a directory 1 level 
deep, and I need the whole tree to be monitored. Does anyone know a 
solution for this? Does the kernel provide facilities for this?

(Please send me replies directly or via CC, as I am not subscribed to 
the kernel mailinglist)

Regards,
  Jeroen van Disseldorp         mailto:jdizzl@xs4all.nl
-- 
Be the change you wish to see in the world    -- Gandhi
