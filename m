Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313759AbSDHV1s>; Mon, 8 Apr 2002 17:27:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313761AbSDHV1r>; Mon, 8 Apr 2002 17:27:47 -0400
Received: from imladris.infradead.org ([194.205.184.45]:16145 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id <S313759AbSDHV1q>; Mon, 8 Apr 2002 17:27:46 -0400
Date: Mon, 8 Apr 2002 22:27:42 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Robert Love <rml@tech9.net>
Cc: "Kuppuswamy, Priyadarshini" <Priyadarshini.Kuppuswamy@compaq.com>,
        linux-kernel@vger.kernel.org
Subject: Re: system call for finding the number of cpus??
Message-ID: <20020408222742.A28352@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Robert Love <rml@tech9.net>,
	"Kuppuswamy,  Priyadarshini" <Priyadarshini.Kuppuswamy@compaq.com>,
	linux-kernel@vger.kernel.org
In-Reply-To: <6B003D25ADBDE347B5542AFE6A55B42E01A4451A@tayexc13.americas.cpqcorp.net> <1018301108.913.167.camel@phantasy>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 08, 2002 at 05:25:08PM -0400, Robert Love wrote:
> Linux does not implement such a syscall.  Note
> 
> 	cat /proc/cpuinfo | grep processor | wc -l
> 
> works and is simple; you do not have to do it via script - execute it in
> your C program, save the one-line output, and atoi() it.

I guess there is at least one architecture on which it breaks..
See http://people.nl.linux.org/~hch/cpuinfo/ for details.
