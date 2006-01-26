Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932138AbWAZJn6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932138AbWAZJn6 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 Jan 2006 04:43:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932210AbWAZJn6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 Jan 2006 04:43:58 -0500
Received: from mx1.redhat.com ([66.187.233.31]:16310 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S932138AbWAZJn5 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 Jan 2006 04:43:57 -0500
From: David Howells <dhowells@redhat.com>
In-Reply-To: <20060125204038.GC12039@hardeman.nu> 
References: <20060125204038.GC12039@hardeman.nu>  <1138048952965@2gen.com> <17515.1138100304@hades.cambridge.redhat.com> 
To: David =?us-ascii?Q?=3D=3Fiso-8859-1=3FQ=3FH=3DE4rdeman=3F=3D?= 
	<david@2gen.com>
Cc: David Howells <dhowells@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 03/04] Add encryption ops to the keyctl syscall 
X-Mailer: MH-E 7.84; nmh 1.1; GNU Emacs 22.0.50.1
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT
Date: Thu, 26 Jan 2006 09:43:58 +0000
Message-ID: <18955.1138268638@hades.cambridge.redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David Härdeman <david@2gen.com> wrote:

> Do you mean that I should move the key_ref_to_ptr call to right after the
> can_read_key label? If that is the case, shouldn't the same thing be done for
> keyctl_read_key?

Quite possibly. I'll have a look at it when I get back from NZ. Actually, it's
possible that the compiler shifts it down anyway since it has no side effects.

David
