Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315666AbSECTY6>; Fri, 3 May 2002 15:24:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315670AbSECTY5>; Fri, 3 May 2002 15:24:57 -0400
Received: from imladris.infradead.org ([194.205.184.45]:22281 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id <S315666AbSECTY4>; Fri, 3 May 2002 15:24:56 -0400
Date: Fri, 3 May 2002 20:24:52 +0100
From: Christoph Hellwig <hch@infradead.org>
To: "Richard B. Johnson" <root@chaos.analogic.com>
Cc: Tony Luck <aegl@yahoo.com>, linux-kernel@vger.kernel.org
Subject: Re: Virtual address space exhaustion (was  Discontigmem virt_to_page() )
Message-ID: <20020503202452.A31648@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	"Richard B. Johnson" <root@chaos.analogic.com>,
	Tony Luck <aegl@yahoo.com>, linux-kernel@vger.kernel.org
In-Reply-To: <20020503200958.A30548@infradead.org> <Pine.LNX.3.95.1020503151302.8450A-100000@chaos.analogic.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 03, 2002 at 03:17:35PM -0400, Richard B. Johnson wrote:
> On Fri, 3 May 2002, Christoph Hellwig wrote:
> 
> > On Fri, May 03, 2002 at 03:01:48PM -0400, Richard B. Johnson wrote:
> > > The other Unix's I've become familiar are Sun-OS, the
> > 
> > SunOS 5 uses separate address spaces on sparcv9 (32 and 64bit).
> > The same is true for many Linux ports, e.g. sparc64 or s390.
> > 
> 
> No no! I'm not talking about the physical address spaces. Many
> CPUs have separate address spaces for separate functions. I'm
> taking about the virtual address space that the process sees.
> There are no holes in this virtual address space of SunOS, and
> no "separate stuff" (I/O space) seen by a user-mode task.

This thread was about separate user/kernel VIRTUAL address spaces.
Not about holes, I/O spaces or other crap.
