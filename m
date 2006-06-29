Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932540AbWF2U4I@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932540AbWF2U4I (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Jun 2006 16:56:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932542AbWF2U4H
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Jun 2006 16:56:07 -0400
Received: from mx1.redhat.com ([66.187.233.31]:23004 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S932540AbWF2U4F (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Jun 2006 16:56:05 -0400
Date: Thu, 29 Jun 2006 16:55:57 -0400
From: Dave Jones <davej@redhat.com>
To: Chris Wedgwood <cw@f00f.org>
Cc: Greg KH <greg@kroah.com>, gregkh@suse.de,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] 64bit Resource: finally enable 64bit resource sizes
Message-ID: <20060629205557.GG13619@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	Chris Wedgwood <cw@f00f.org>, Greg KH <greg@kroah.com>,
	gregkh@suse.de,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <200606291801.k5TI12br003227@hera.kernel.org> <20060629204206.GA3010@tuatara.stupidest.org> <20060629204527.GD13619@redhat.com> <20060629205213.GA3534@tuatara.stupidest.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060629205213.GA3534@tuatara.stupidest.org>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 29, 2006 at 01:52:13PM -0700, Chris Wedgwood wrote:
 > On Thu, Jun 29, 2006 at 04:45:27PM -0400, Dave Jones wrote:
 > 
 > Yeah I just test and it does the right think for iamd64
 > 
 > > +config RESOURCES_64BIT
 > > +       bool "64 bit Memory and IO resources (EXPERIMENTAL)" if (!64BIT && EXPERIMENTAL)
 > > +       default 64BIT
 >                   ^^^^^ ?
 > is that right?

arch/x86_64/Kconfig has ..

config 64BIT
    def_bool y

so why not ?

		Dave

-- 
http://www.codemonkey.org.uk
