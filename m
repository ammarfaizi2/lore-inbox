Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315929AbSGQRhs>; Wed, 17 Jul 2002 13:37:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315941AbSGQRhs>; Wed, 17 Jul 2002 13:37:48 -0400
Received: from holomorphy.com ([66.224.33.161]:26247 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id <S315929AbSGQRhr>;
	Wed, 17 Jul 2002 13:37:47 -0400
Date: Wed, 17 Jul 2002 10:40:36 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Ingo Molnar <mingo@elte.hu>
Cc: shreenivasa H V <shreenihv@usa.net>, linux-kernel@vger.kernel.org
Subject: Re: Gang Scheduling in linux
Message-ID: <20020717174036.GG1096@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Ingo Molnar <mingo@elte.hu>, shreenivasa H V <shreenihv@usa.net>,
	linux-kernel@vger.kernel.org
References: <20020716225441.23939.qmail@uwdvg008.cms.usa.net> <Pine.LNX.4.44.0207181818300.29003-100000@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Description: brief message
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0207181818300.29003-100000@localhost.localdomain>
User-Agent: Mutt/1.3.25i
Organization: The Domain of Holomorphy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 18, 2002 at 06:21:41PM +0200, Ingo Molnar wrote:
> yes - the 'synchronous wakeup' feature is a form of gang scheduling. It in
> essence uses real process-communication information to migrate 'related'
> tasks to the same CPU. So it's automatic, no need to declare processes to
> be part of a 'gang' in some formal (and thus fundamentally imperfect) way.
> (another form of 'gang scheduling' can be achieved by binding the 'parent'
> process to a single CPU - all children will be bound to that CPU as well.)

Hit #1 on google.com: http://www.sw.nec.co.jp/hpc/sx-e/sx-world/no23/en10.pdf

   [SX-5 SERIES TECHNICAL HIGHLIGHTS]
   Overview of Gang Scheduling
   Koichi Nakanishi,
   Senior Manager
   Koji Suzuki,
   Assistant Manager                                                            
   4th Development Department, 1st Computers Software Division, Computers       
   Software Operations Unit, NEC Corporation                                    
   SX WORLD                                                                     
   Autumn 1998 No.23 Special Issue

[...]

   The Gang scheduling function has the func-     
   tion of simultaneously allocating the required  
   number of CPUs when scheduling parallel             
   programs, and allows you to obtain almost  
   the same performance when multiple parallel  
   programs are simultaneously executing, as if  
   the programs were running alone.              


I have approximately zero interest in this myself, but something seemed
off about the definition of gang scheduling being used in the post.


Cheers,
Bill
