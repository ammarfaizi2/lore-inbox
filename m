Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262001AbUJYQAN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262001AbUJYQAN (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 25 Oct 2004 12:00:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262031AbUJYQAB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 25 Oct 2004 12:00:01 -0400
Received: from linux01.gwdg.de ([134.76.13.21]:41964 "EHLO linux01.gwdg.de")
	by vger.kernel.org with ESMTP id S262008AbUJYPrK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 25 Oct 2004 11:47:10 -0400
Date: Mon, 25 Oct 2004 17:46:52 +0200 (MEST)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>
cc: Trond Myklebust <trond.myklebust@fys.uio.no>, linux-kernel@vger.kernel.org
Subject: Re: Temporary NFS problem when rpciod is SIGKILLed
In-Reply-To: <200410251831.10849.vda@port.imtp.ilyichevsk.odessa.ua>
Message-ID: <Pine.LNX.4.53.0410251746220.776@yvahk01.tjqt.qr>
References: <200410251702.58622.vda@port.imtp.ilyichevsk.odessa.ua>
 <200410251812.28663.vda@port.imtp.ilyichevsk.odessa.ua>
 <Pine.LNX.4.53.0410251717320.19116@yvahk01.tjqt.qr>
 <200410251831.10849.vda@port.imtp.ilyichevsk.odessa.ua>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=koi8-r
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>It is not killable, neither 2.4 nor 2.6 one. It is by design I think,
>because I *must not* kill it, or else NFS rootfs will fall off
>and box will hang.

If it's not killable (per kill(2)), why can killall5 (which will probably use
kill(2)!) do it?


Jan Engelhardt
-- 
Gesellschaft für Wissenschaftliche Datenverarbeitung
Am Fassberg, 37077 Göttingen, www.gwdg.de
