Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317665AbSGPMac>; Tue, 16 Jul 2002 08:30:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317670AbSGPMab>; Tue, 16 Jul 2002 08:30:31 -0400
Received: from krusty.dt.E-Technik.Uni-Dortmund.DE ([129.217.163.1]:51718 "EHLO
	mail.dt.e-technik.uni-dortmund.de") by vger.kernel.org with ESMTP
	id <S317665AbSGPMaa>; Tue, 16 Jul 2002 08:30:30 -0400
Date: Tue, 16 Jul 2002 14:33:24 +0200
From: Matthias Andree <matthias.andree@stud.uni-dortmund.de>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [ANNOUNCE] Ext3 vs Reiserfs benchmarks
Message-ID: <20020716123324.GF4576@merlin.emma.line.org>
Mail-Followup-To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <s5g7kjwsn12.fsf@egghead.curl.com> <Pine.LNX.4.44.0207152356430.19217-100000@lexx.infeline.org> <20020716020845.Z28720@mea-ext.zmailer.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20020716020845.Z28720@mea-ext.zmailer.org>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 16 Jul 2002, Matti Aarnio wrote:

>   These days, usually, the transaction database for MTAs is UNIX
>   filesystem.   For ZMailer I have considered (although not actually
>   done - yet) using SleepyCat DB files for the transaction subsystem.
>   There are great challenges in failure compartementalisation, and
>   integrity, when using that kind of integrated database mechanisms.
>   Getting SEGV is potentially _very_ bad thing!

Read: lethal to the spool. Has SleepyCat DB learned to recover from
ENOSPC in the meanwhile? I had a db1.85 file corrupt after ENOSPC once...

-- 
Matthias Andree
