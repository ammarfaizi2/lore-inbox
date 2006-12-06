Return-Path: <linux-kernel-owner+willy=40w.ods.org-S936194AbWLFQNl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S936194AbWLFQNl (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Dec 2006 11:13:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S936264AbWLFQNl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Dec 2006 11:13:41 -0500
Received: from iona.labri.fr ([147.210.8.143]:59391 "EHLO iona.labri.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S936194AbWLFQNk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Dec 2006 11:13:40 -0500
Date: Wed, 6 Dec 2006 17:14:05 +0100
From: Samuel Thibault <samuel.thibault@ens-lyon.org>
To: "H. Peter Anvin" <hpa@zytor.com>
Cc: Arjan van de Ven <arjan@infradead.org>, linux-kernel@vger.kernel.org
Subject: Re: Linux should define ENOTSUP
Message-ID: <20061206161405.GV3927@implementation.labri.fr>
Mail-Followup-To: Samuel Thibault <samuel.thibault@ens-lyon.org>,
	"H. Peter Anvin" <hpa@zytor.com>,
	Arjan van de Ven <arjan@infradead.org>,
	linux-kernel@vger.kernel.org
References: <20061206135134.GJ3927@implementation.labri.fr> <1165415115.3233.449.camel@laptopd505.fenrus.org> <4576DED7.10800@zytor.com> <20061206152542.GS3927@implementation.labri.fr> <4576E134.5020109@zytor.com> <20061206153404.GU3927@implementation.labri.fr> <4576E355.7080708@zytor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <4576E355.7080708@zytor.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

H. Peter Anvin, le Wed 06 Dec 2006 07:35:49 -0800, a écrit :
> Samuel Thibault wrote:
> >>The two can't be done at the same time.  In fact, the two probably can't 
> >>be done without a period of quite a few *years* between them.
> >
> >Not a reason for not doing it ;)
> 
> No, but breakage is.  There has to be a major benefit to justify the 
> cost, and you, at least, have not provided such a justification.

Well, as I said, existing code like

switch(errno) {
	case ENOTSUP:
		foo();
		break;
	case EOPNOTSUP:
		bar();
		break;
}

Samuel
