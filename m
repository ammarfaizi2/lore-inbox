Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271419AbTHDJHx (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Aug 2003 05:07:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271420AbTHDJHx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Aug 2003 05:07:53 -0400
Received: from main.gmane.org ([80.91.224.249]:30615 "EHLO main.gmane.org")
	by vger.kernel.org with ESMTP id S271419AbTHDJHw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Aug 2003 05:07:52 -0400
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: mru@users.sourceforge.net (=?iso-8859-1?q?M=E5ns_Rullg=E5rd?=)
Subject: Re: 2.6 ide i/o performance
Date: Mon, 04 Aug 2003 11:04:42 +0200
Message-ID: <yw1xel01kd3p.fsf@users.sourceforge.net>
References: <200308021205.59280.vt@vt.fermentas.lt>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
X-Complaints-To: usenet@main.gmane.org
User-Agent: Gnus/5.1002 (Gnus v5.10.2) XEmacs/21.4 (Rational FORTRAN, linux)
Cancel-Lock: sha1:3Xf1tX1r78ffBbGLQJN3xqQDzSQ=
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Vitalis Tiknius <vt@vt.fermentas.lt> writes:

> i simultaneously burned (audio mode, without scsi emulation) and ripped cd's 
> under 2.6.0-test2-mm2. devices are:
>
>  ../ide/host0/bus1/target0/lun0/cd (Teac CD-W552E) 
>  ../ide/host0/bus1/target1/lun0/cd (Teac DV-516E).
>
> mobo is Intel 875. software is k3b-0.9, cdrtools-2.01_alpha18, grip-3.1.1, and 
> cdparanoia-3.9.8 with all paranoia options on.
>
> when burning and ripping are performed separately, their speeds are approx. 
> 42x and 6.3x. when simultaneously, 12x and 1.6x with no options touched.
>
> although devices are on the same controller (my first controller is
> SATA) and on the same bus, i'd rather expect linear and not almost
> square-law throughput regression observed. are the things expected
> to go this way, or there is some room for optimizations, etc.?

The first thing to do is to use separate cables for those devices, and
see if it helps.

-- 
Måns Rullgård
mru@users.sf.net

