Return-Path: <linux-kernel-owner+willy=40w.ods.org-S934378AbWLFPZS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934378AbWLFPZS (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Dec 2006 10:25:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S935226AbWLFPZS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Dec 2006 10:25:18 -0500
Received: from iona.labri.fr ([147.210.8.143]:58002 "EHLO iona.labri.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S934378AbWLFPZP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Dec 2006 10:25:15 -0500
Date: Wed, 6 Dec 2006 16:25:42 +0100
From: Samuel Thibault <samuel.thibault@ens-lyon.org>
To: "H. Peter Anvin" <hpa@zytor.com>
Cc: Arjan van de Ven <arjan@infradead.org>, linux-kernel@vger.kernel.org
Subject: Re: Linux should define ENOTSUP
Message-ID: <20061206152542.GS3927@implementation.labri.fr>
Mail-Followup-To: Samuel Thibault <samuel.thibault@ens-lyon.org>,
	"H. Peter Anvin" <hpa@zytor.com>,
	Arjan van de Ven <arjan@infradead.org>,
	linux-kernel@vger.kernel.org
References: <20061206135134.GJ3927@implementation.labri.fr> <1165415115.3233.449.camel@laptopd505.fenrus.org> <4576DED7.10800@zytor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <4576DED7.10800@zytor.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

H. Peter Anvin, le Wed 06 Dec 2006 07:16:39 -0800, a écrit :
> Arjan van de Ven wrote:
> >>Is there any way to fix this?  Glibc people don't seem to want to fix it
> >>on their part, see
> >>http://sources.redhat.com/bugzilla/show_bug.cgi?id=2363
> >
> >Hi,
> >
> >Ulrich asked you to go to us once your time travel machine was
> >finished.. is it finished yet ?  ;=)
> >
> >this is part of the ABI, so we can't change this in 2006...
> >
> 
> If ENOTSUP is currently unused and is only there for completeness, then 
> it should be fine to add it.

The functions that should be returning it instead of EOPNOTSUP should be
fixed too.

Samuel
