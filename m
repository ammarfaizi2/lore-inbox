Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129231AbQLDSW7>; Mon, 4 Dec 2000 13:22:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129314AbQLDSWt>; Mon, 4 Dec 2000 13:22:49 -0500
Received: from fromage.dsndata.com ([198.183.6.16]:1284 "EHLO
	fromage.dsndata.com") by vger.kernel.org with ESMTP
	id <S129231AbQLDSWf>; Mon, 4 Dec 2000 13:22:35 -0500
Date: Mon, 4 Dec 2000 11:52:36 -0600
From: Jeff Epler <jepler@dsndata.com>
To: linux-kernel@vger.kernel.org
Subject: Re: Path: for oom_kill.c
Message-ID: <20001204115236.B974@dsndata.com>
Mail-Followup-To: linux-kernel@vger.kernel.org
In-Reply-To: <20001204162712Z129770-439+868@vger.kernel.org> <Pine.LNX.4.21.0012041456100.29258-100000@duckman.distro.conectiva>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0.1i
In-Reply-To: <Pine.LNX.4.21.0012041456100.29258-100000@duckman.distro.conectiva>; from riel@conectiva.com.br on Mon, Dec 04, 2000 at 02:57:34PM -0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 04, 2000 at 02:57:34PM -0200, Rik van Riel wrote:
> On Sat, 2 Dec 2000, hugang wrote:
> 
> > Hello all:
> > 	
> > old    ---->     points = p->mm->total_vm;
> >        
> > change to --->   points = p->pid;
> 
> Ummm, what exactly do you want to achieve with this?

I suspect that hugang whishes to kill the newest process.  However,
this will not work after PID wrap.

Jeff
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
