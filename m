Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281420AbRKTWM4>; Tue, 20 Nov 2001 17:12:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281435AbRKTWMr>; Tue, 20 Nov 2001 17:12:47 -0500
Received: from cerebus.wirex.com ([65.102.14.138]:17149 "EHLO
	figure1.int.wirex.com") by vger.kernel.org with ESMTP
	id <S281441AbRKTWMf>; Tue, 20 Nov 2001 17:12:35 -0500
Date: Tue, 20 Nov 2001 14:05:48 -0800
From: Chris Wright <chris@wirex.com>
To: Luis Miguel Correia Henriques <umiguel@alunos.deis.isec.pt>
Cc: linux-kernel@vger.kernel.org
Subject: Re: copy to user
Message-ID: <20011120140548.A12208@figure1.int.wirex.com>
Mail-Followup-To: Luis Miguel Correia Henriques <umiguel@alunos.deis.isec.pt>,
	linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.31.0111202040180.23000-100000@mail.deis.isec.pt>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.LNX.4.31.0111202040180.23000-100000@mail.deis.isec.pt>; from umiguel@alunos.deis.isec.pt on Tue, Nov 20, 2001 at 08:54:42PM +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Luis Miguel Correia Henriques (umiguel@alunos.deis.isec.pt) wrote:
> The reason that I need it to spend CPU time is that I'm developing a fault
> injector. The purpose of a fault injection tool is, as you could imagine,
> to test some critical systems and it's capacity to recover from fails. The
> reason for changing the code of a process is that process must be delayed
> but without leaving the CPU - everything must look like nothing wrong is
> happening, except for other processes that are waiting for something from
> the delayed process...

with ptrace(2) you can write into the program's .bss, whatever...add a
little shellcode and you're dangerous ;-)

-chris
