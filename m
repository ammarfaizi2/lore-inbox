Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262637AbVAVUVZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262637AbVAVUVZ (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 22 Jan 2005 15:21:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262697AbVAVUVY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 22 Jan 2005 15:21:24 -0500
Received: from mail.joq.us ([67.65.12.105]:56971 "EHLO sulphur.joq.us")
	by vger.kernel.org with ESMTP id S262637AbVAVUVO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 22 Jan 2005 15:21:14 -0500
To: Con Kolivas <kernel@kolivas.org>
Cc: Rui Nuno Capela <rncbc@rncbc.org>, linux <linux-kernel@vger.kernel.org>,
       Ingo Molnar <mingo@elte.hu>, rlrevell@joe-job.com,
       paul@linuxaudiosystems.com, CK Kernel <ck@vds.kolivas.org>,
       utz <utz@s2y4n2c.de>, Andrew Morton <akpm@osdl.org>, alexn@dsv.su.se
Subject: Re: [PATCH]sched: Isochronous class v2 for unprivileged soft rt 
 scheduling
References: <41EEE1B1.9080909@kolivas.org> <41EF00ED.4070908@kolivas.org>
	<873bwwga0w.fsf@sulphur.joq.us> <41EF123D.703@kolivas.org>
	<87ekgges2o.fsf@sulphur.joq.us> <41EF2E7E.8070604@kolivas.org>
	<87oefkd7ew.fsf@sulphur.joq.us>
	<10752.195.245.190.93.1106211979.squirrel@195.245.190.93>
	<65352.195.245.190.94.1106240981.squirrel@195.245.190.94>
	<41F19907.2020809@kolivas.org> <87k6q6c7fz.fsf@sulphur.joq.us>
	<41F1F735.1000603@kolivas.org> <41F1F7AF.7000105@kolivas.org>
	<41F1FC1D.10308@kolivas.org>
From: "Jack O'Quin" <joq@io.com>
Date: Sat, 22 Jan 2005 14:22:42 -0600
In-Reply-To: <41F1FC1D.10308@kolivas.org> (Con Kolivas's message of "Sat, 22
 Jan 2005 18:09:17 +1100")
Message-ID: <87wtu55i3x.fsf@sulphur.joq.us>
User-Agent: Gnus/5.1006 (Gnus v5.10.6) XEmacs/21.4 (Corporate Culture,
 linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Con Kolivas <kernel@kolivas.org> writes:

> So let's try again, sorry about the noise:
>
> ==> jack_test4-2.6.11-rc1-mm2-fifo.log <==
> *********************************************
> XRUN Count  . . . . . . . . . :     3
> Delay Maximum . . . . . . . . : 20161   usecs
> *********************************************
>
> ==> jack_test4-2.6.11-rc1-mm2-iso.log <==
> *********************************************
> XRUN Count  . . . . . . . . . :     6
> Delay Maximum . . . . . . . . :  4604   usecs
> *********************************************
>
> Pretty pictures:
> http://ck.kolivas.org/patches/SCHED_ISO/iso2-benchmarks/

Neither run exhibits reliable audio performance.  There is some low
latency performance problem with your system.  Maybe ReiserFS is
causing trouble even with logging turned off.  Perhaps the problem is
somewhere else.  Maybe some device is misbehaving.

Until you solve this problem, beware of drawing conclusions.
-- 
  joq
