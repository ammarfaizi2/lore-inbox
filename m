Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263025AbTESWbh (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 May 2003 18:31:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263171AbTESWbh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 May 2003 18:31:37 -0400
Received: from holomorphy.com ([66.224.33.161]:39401 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id S263025AbTESWbg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 May 2003 18:31:36 -0400
Date: Mon, 19 May 2003 15:44:14 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: "H. Peter Anvin" <hpa@zytor.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Recent changes to sysctl.h breaks glibc
Message-ID: <20030519224414.GG8978@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	"H. Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org
References: <1053289316.10127.41.camel@nosferatu.lan> <20030519063813.A30004@infradead.org> <1053341023.9152.64.camel@workshop.saharact.lan> <20030519105152.GD8978@holomorphy.com> <babheo$s9r$1@cesium.transmeta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <babheo$s9r$1@cesium.transmeta.com>
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Followup to:  <20030519105152.GD8978@holomorphy.com>
By author:    William Lee Irwin III <wli@holomorphy.com>
In newsgroup: linux.dev.kernel
>> IIRC you're supposed to use some sort of sanitized copy, not the things
>> directly. IMHO the current state of affairs sucks as there is no
>> standard set of ABI headers, but grabbing them right out of the kernel
>> is definitely not the way to go.

On Mon, May 19, 2003 at 02:14:00PM -0700, H. Peter Anvin wrote:
> This "cure" sucks worse than the disease.  Now you're putting it onto
> everyone who maintains userspace to do the same repetitive task of
> "sanitizing" this.  Especially for things this trivial, this is a
> ridiculous concept.
> For 2.7, getting real exportable ABI headers is so bloody necessary
> it's not even funny.  However, for 2.5, breaking things randomly is
> not the way to go.

I would rather have real exportable ABI headers, yes. We don't have
them and AFAIK sanitized copies are the current policy.


-- wli
