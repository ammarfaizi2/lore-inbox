Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262389AbUD2C3q@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262389AbUD2C3q (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Apr 2004 22:29:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262418AbUD2C3q
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Apr 2004 22:29:46 -0400
Received: from florence.buici.com ([206.124.142.26]:29830 "HELO
	florence.buici.com") by vger.kernel.org with SMTP id S262389AbUD2C3p
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Apr 2004 22:29:45 -0400
Date: Wed, 28 Apr 2004 19:29:44 -0700
From: Marc Singer <elf@buici.com>
To: Andrew Morton <akpm@osdl.org>
Cc: Rik van Riel <riel@redhat.com>, brettspamacct@fastclick.com,
       jgarzik@pobox.com, linux-kernel@vger.kernel.org
Subject: Re: ~500 megs cached yet 2.6.5 goes into swap hell
Message-ID: <20040429022944.GA24000@buici.com>
References: <20040428180038.73a38683.akpm@osdl.org> <Pine.LNX.4.44.0404282143360.19633-100000@chimarrao.boston.redhat.com> <20040428185720.07a3da4d.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040428185720.07a3da4d.akpm@osdl.org>
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 28, 2004 at 06:57:20PM -0700, Andrew Morton wrote:
> Rik van Riel <riel@redhat.com> wrote:
> >
> >  IMHO, the VM on a desktop system really should be optimised to
> >  have the best interactive behaviour, meaning decent latency
> >  when switching applications.
> 
> I'm gonna stick my fingers in my ears and sing "la la la" until people tell
> me "I set swappiness to zero and it didn't do what I wanted it to do".

It does, but it's a bit too coarse of a solution.  It just means that
the page cache always loses.

