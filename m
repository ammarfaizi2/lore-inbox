Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262677AbUKXQSx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262677AbUKXQSx (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 24 Nov 2004 11:18:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262687AbUKXQQv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 24 Nov 2004 11:16:51 -0500
Received: from [213.146.154.40] ([213.146.154.40]:35037 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S262681AbUKXNNz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 24 Nov 2004 08:13:55 -0500
Date: Wed, 24 Nov 2004 13:13:54 +0000
From: Christoph Hellwig <hch@infradead.org>
To: Nigel Cunningham <ncunningham@linuxmail.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Suspend 2 merge: 8/51: /proc/acpi/sleep hook.
Message-ID: <20041124131354.GB12868@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Nigel Cunningham <ncunningham@linuxmail.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <1101292194.5805.180.camel@desktop.cunninghams> <1101293562.5805.214.camel@desktop.cunninghams>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1101293562.5805.214.camel@desktop.cunninghams>
User-Agent: Mutt/1.4.1i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 24, 2004 at 11:57:25PM +1100, Nigel Cunningham wrote:
> Same thing as the previous patch, but for /proc/acpi/sleep.

And again totally bogus.  Make sure swsusp and swsusp2 export the same
interface.  Preferably the old one, but if it absolutely doesn't fit
your needs submit a patch to switch the old code to the new interface
first.

