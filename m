Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261631AbVAMOPn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261631AbVAMOPn (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 Jan 2005 09:15:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261634AbVAMOPn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 Jan 2005 09:15:43 -0500
Received: from mx1.redhat.com ([66.187.233.31]:57799 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S261631AbVAMOPe (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 Jan 2005 09:15:34 -0500
Date: Thu, 13 Jan 2005 09:15:22 -0500
From: Jakub Jelinek <jakub@redhat.com>
To: linux-kernel@vger.kernel.org
Subject: Re: propolice support for linux
Message-ID: <20050113141522.GX10340@devserv.devel.redhat.com>
Reply-To: Jakub Jelinek <jakub@redhat.com>
References: <20050113134620.GA14127@boetes.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050113134620.GA14127@boetes.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 13, 2005 at 02:45:58PM +0059, Han Boetes wrote:
> Hi,
> 
> The propolice gcc-extension prevents buffer-overflows in binaries:
> 
>   http://www.research.ibm.com/trl/projects/security/ssp/
> 
> The effect is that all buffer-overflow exploits are turned into a
> -- logged -- Denial of service.

This is little bit too strong.
The effect is that it detects some stack buffer-overflow exploits.

	Jakub
