Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262546AbTJAT17 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Oct 2003 15:27:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262547AbTJAT17
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Oct 2003 15:27:59 -0400
Received: from mx1.redhat.com ([66.187.233.31]:34564 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S262546AbTJAT14 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Oct 2003 15:27:56 -0400
Date: Wed, 1 Oct 2003 15:27:58 -0400 (EDT)
From: James Morris <jmorris@redhat.com>
X-X-Sender: jmorris@thoron.boston.redhat.com
To: John Lange <john.lange@bighostbox.com>
cc: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: A new model for ports and kernel security?
In-Reply-To: <1065035183.5142.50.camel@mars>
Message-ID: <Pine.LNX.4.44.0310011523510.14121-100000@thoron.boston.redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 1 Oct 2003, John Lange wrote:

> Suggestion: A groups based port binding security system for both
> outgoing and incoming port binding.

Something like this for port binding exists as an external patch:
http://www.olafdietsche.de/linux/accessfs/

> I realize similar things can be accomplished in other ways (with
> iptables I believe) but it just seems to me that this should be a
> fundamental part of the systems security and therefore should be in the
> kernel by default (just as the root binding to low ports is currently).

We should keep the standard behavior as default in the core kernel.  Other 
security models can be implemented via LSM, Netfilter, config options etc.


- James
-- 
James Morris
<jmorris@redhat.com>



