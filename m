Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315540AbSEQKWp>; Fri, 17 May 2002 06:22:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315548AbSEQKWo>; Fri, 17 May 2002 06:22:44 -0400
Received: from imladris.infradead.org ([194.205.184.45]:26638 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id <S315540AbSEQKWo>; Fri, 17 May 2002 06:22:44 -0400
Date: Fri, 17 May 2002 11:20:54 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Rusty Russell <rusty@rustcorp.com.au>
Cc: torvalds@transmeta.com, linux-kernel@vger.kernel.org
Subject: Re: AUDIT: copy_from_user is a deathtrap.
Message-ID: <20020517112054.A13933@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Rusty Russell <rusty@rustcorp.com.au>, torvalds@transmeta.com,
	linux-kernel@vger.kernel.org
In-Reply-To: <E178e1l-0007qB-00@wagner.rustcorp.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 17, 2002 at 07:27:54PM +1000, Rusty Russell wrote:
> Linus,
> 
> 	Should I change copy_to/from_user to return -EFAULT, or
> introduce a new copy_to/from_uspace which does and start moving
> everything across?

copyin/copyout! :)

