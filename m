Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264038AbTKJSCv (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 Nov 2003 13:02:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264041AbTKJSCv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 Nov 2003 13:02:51 -0500
Received: from pc0312b.RZ.UniBw-Muenchen.de ([137.193.10.28]:691 "EHLO
	pc0312b.rz.unibw-muenchen.de") by vger.kernel.org with ESMTP
	id S264038AbTKJSCu convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 Nov 2003 13:02:50 -0500
From: Lutz Bichler <Lutz.Bichler@unibw-muenchen.de>
Organization: University of the Federal Armed Forces Munich
To: linux-kernel@vger.kernel.org
Subject: PCNET32 - Driver
Date: Mon, 10 Nov 2003 18:57:25 +0100
User-Agent: KMail/1.5.4
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Message-Id: <200311101857.25806.Lutz.Bichler@unibw-muenchen.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

i needed to add the following code snippet to the pcnet32 - driver in order to 
make it work with new Allied Telesync fiber channel cards. 

600,603d599
<     case 0x2628:
<         chipname = "PCnet/FAST III 79C976";
<         fdx = 1; mii = 1;
<         break;

>From the drivers source it is not clear to me who actually maintains the 
driver. Who is the maintainer and how can i get this (or something better of 
course) merged into the driver? Please CC as i am not subscribed to the list.

Lutz
