Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751299AbWF2UwN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751299AbWF2UwN (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Jun 2006 16:52:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751301AbWF2UwN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Jun 2006 16:52:13 -0400
Received: from smtp106.sbc.mail.mud.yahoo.com ([68.142.198.205]:48542 "HELO
	smtp106.sbc.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S1751299AbWF2UwM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Jun 2006 16:52:12 -0400
Date: Thu, 29 Jun 2006 13:52:13 -0700
From: Chris Wedgwood <cw@f00f.org>
To: Dave Jones <davej@redhat.com>, Greg KH <greg@kroah.com>, gregkh@suse.de,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] 64bit Resource: finally enable 64bit resource sizes
Message-ID: <20060629205213.GA3534@tuatara.stupidest.org>
References: <200606291801.k5TI12br003227@hera.kernel.org> <20060629204206.GA3010@tuatara.stupidest.org> <20060629204527.GD13619@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060629204527.GD13619@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 29, 2006 at 04:45:27PM -0400, Dave Jones wrote:

Yeah I just test and it does the right think for iamd64

> +config RESOURCES_64BIT
> +       bool "64 bit Memory and IO resources (EXPERIMENTAL)" if (!64BIT && EXPERIMENTAL)
> +       default 64BIT
                  ^^^^^ ?
is that right?
