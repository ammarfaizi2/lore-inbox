Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271272AbTGWUBQ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Jul 2003 16:01:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271274AbTGWUBQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Jul 2003 16:01:16 -0400
Received: from webmail.insa-lyon.fr ([134.214.79.204]:35274 "EHLO
	mail.insa-lyon.fr") by vger.kernel.org with ESMTP id S271272AbTGWUBO
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Jul 2003 16:01:14 -0400
Date: Wed, 23 Jul 2003 22:16:19 +0200
From: Aurelien Jarno <aurelien@aurel32.net>
To: Herbert Xu <herbert@gondor.apana.org.au>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.4.22-pre7: are security issues solved?
Message-ID: <20030723201619.GA21303@pc.aurel32>
Mail-Followup-To: Aurelien Jarno <aurelien@aurel32.net>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	linux-kernel@vger.kernel.org
References: <Pine.LNX.4.44.0307212234390.3580-100000@localhost.localdomain> <E19fGMZ-0000Zm-00@gondolin.me.apana.org.au> <20030723033505.145db6b8.davem@redhat.com> <20030723104753.GA2479@gondor.apana.org.au> <20030723035022.23a75bc5.davem@redhat.com> <20030723105903.GA2582@gondor.apana.org.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <20030723105903.GA2582@gondor.apana.org.au>
X-Mailer: Mutt 1.5.4i (2003-03-19)
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 23, 2003 at 08:59:03PM +1000, Herbert Xu wrote:
> Anyway, I'm not that bothered with making /proc/tty/driver root-only,
> even if it is only for what seems to me to be dubious reasons.

Or maybe it is possible to update this information with a longer period.
Let's say for example 5 seconds. So it is almost impossible to determine
the length of a password.

It is a little more complicated, but it has the advantage that the
statistics about the serial ports are still available for normal users.

Aurelien
