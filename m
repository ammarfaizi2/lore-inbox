Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317112AbSFQWoU>; Mon, 17 Jun 2002 18:44:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317115AbSFQWoU>; Mon, 17 Jun 2002 18:44:20 -0400
Received: from mail.skjellin.net ([193.69.71.67]:42213 "HELO mail.skjellin.net")
	by vger.kernel.org with SMTP id <S317112AbSFQWoS> convert rfc822-to-8bit;
	Mon, 17 Jun 2002 18:44:18 -0400
Subject: Re: invalidate: busy buffer
From: Andre Tomt <andre@tomt.net>
To: linux-kernel@vger.kernel.org
Cc: Andrew Rodland <arodland@noln.com>
In-Reply-To: <20020617182137.5158103f.arodland@noln.com>
References: <000701c2164c$65630930$0501a8c0@Stev.org> 
	<20020617182137.5158103f.arodland@noln.com>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
X-Mailer: Ximian Evolution 1.0.7 
Date: 18 Jun 2002 00:46:14 +0200
Message-Id: <1024353974.32508.4.camel@slurv.tomt.lan>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2002-06-18 at 00:21, Andrew Rodland wrote:
> On Mon, 17 Jun 2002 23:14:48 +0100
> "James Stevenson" <mistral@stev.org> wrote:
> 
> Something tried to wipe out all of the caches for some device, but
> something else was using it at the time. For example, if you try to run
> parted on something mounted (and bypass/confuse its mountedness check)
> you'll see this. Were you doing anything like that?

or run for example hdparm -tT device to do a (imho pretty useless)
"benchmark" of io throughput.

-- 
André Tomt
andre@tomt.net

