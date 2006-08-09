Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030547AbWHIGcm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030547AbWHIGcm (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Aug 2006 02:32:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030549AbWHIGcl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Aug 2006 02:32:41 -0400
Received: from nf-out-0910.google.com ([64.233.182.189]:19188 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S1030547AbWHIGcl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Aug 2006 02:32:41 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:sender:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references:x-google-sender-auth;
        b=fBgWupJ4Btm7ZJ9xIM0XpH5W4fLC9weYlu2WwHFmVamvaZbGrYaqkLr+bCBdEqpDHJ+uv8rErFTLTGEOaO7kRL9inXW+PAXap/nn7bjDjWgmEk6FPCYhr5uKv0yVTjtlIGNey73SYRv3s0gcpqcJEvnjUyVZMCX6+xNbQuwMMH4=
Message-ID: <84144f020608082332s5f6f4faboc007faf358a98f82@mail.gmail.com>
Date: Wed, 9 Aug 2006 09:32:20 +0300
From: "Pekka Enberg" <penberg@cs.helsinki.fi>
To: "Theodore Tso" <tytso@mit.edu>, "Kari Hurtta" <hurtta+gmane@siilo.fmi.fi>,
       linux-kernel@vger.kernel.org
Subject: Re: [RFC/PATCH] revoke/frevoke system calls V2
In-Reply-To: <20060808215450.GA12365@thunk.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <Pine.LNX.4.58.0607271722430.4663@sbz-30.cs.Helsinki.FI>
	 <eb8g8b$837$1@taverner.cs.berkeley.edu>
	 <20060807225642.GA31752@nevyn.them.org>
	 <200608071813.18661.chase.venters@clientec.com>
	 <84144f020608080516k183072efmdcc8a4dfc334b2fe@mail.gmail.com>
	 <5dpsfbrzaw.fsf@attruh.keh.iki.fi> <20060808215450.GA12365@thunk.org>
X-Google-Sender-Auth: 1001acb7652e30c8
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 08, 2006 at 07:02:15PM +0300, Kari Hurtta wrote:
> > So application can not close() it and recover file description?

On 8/9/06, Theodore Tso <tytso@mit.edu> wrote:
> That would be correct behavior, IMHO, and matches what happens with a
> tty hangup.

Agreed.

                                           Pekka
