Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316666AbSGLQqy>; Fri, 12 Jul 2002 12:46:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316667AbSGLQqw>; Fri, 12 Jul 2002 12:46:52 -0400
Received: from smtp.eol.ca ([205.189.152.19]:35288 "HELO smtp.eol.ca")
	by vger.kernel.org with SMTP id <S316666AbSGLQqr>;
	Fri, 12 Jul 2002 12:46:47 -0400
Date: Fri, 12 Jul 2002 12:49:31 -0400
From: William Park <opengeometry@yahoo.ca>
To: linux-kernel@vger.kernel.org
Subject: Re: Advice saught on math functions
Message-ID: <20020712164931.GA1830@node1.opengeometry.net>
Mail-Followup-To: linux-kernel@vger.kernel.org
References: <E17T1a9-00037I-00@the-village.bc.nu> <20020712162229.GC2348@werewolf.able.es>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20020712162229.GC2348@werewolf.able.es>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 12, 2002 at 06:22:29PM +0200, J.A. Magallon wrote:
> 
> On 2002.07.12 Alan Cox wrote:
> >> Are these functions which are supplied by the FPU?  I've looked
> >> through the fpu emulation headers and exp() is the only one I can find
> >
> >You can't use FPU operations in the x86 kernel.
> 
> Are you to worried about precission ? Can't you just do your sin() etc.
> in fixed point ? (and move all your fpdata to fixed point, of course)

Or, you can use polynomial approximations.

-- 
William Park, Open Geometry Consulting, <opengeometry@yahoo.ca>
8-CPU Cluster, Hosting, NAS, Linux, LaTeX, python, vim, mutt, tin
