Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271116AbTHHMzA (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Aug 2003 08:55:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271182AbTHHMzA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Aug 2003 08:55:00 -0400
Received: from verdi.et.tudelft.nl ([130.161.38.158]:16769 "EHLO
	verdi.et.tudelft.nl") by vger.kernel.org with ESMTP id S271116AbTHHMy7
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Aug 2003 08:54:59 -0400
Date: Fri, 8 Aug 2003 14:54:44 +0200
From: Rob van Nieuwkerk <robn@verdi.et.tudelft.nl>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Rob van Nieuwkerk <robn@verdi.et.tudelft.nl>, linux-kernel@vger.kernel.org,
       marcelo@conectiva.com.br, sct@redhat.com
Subject: Re: 2.4.22-rc1 FIFO bug still present
Message-Id: <20030808145444.388dc9e6.robn@verdi.et.tudelft.nl>
In-Reply-To: <1060346384.4933.34.camel@dhcp22.swansea.linux.org.uk>
References: <20030806192306.6085b3e0.robn@verdi.et.tudelft.nl>
	<1060346384.4933.34.camel@dhcp22.swansea.linux.org.uk>
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 08 Aug 2003 13:39:44 +0100
Alan Cox <alan@lxorguk.ukuu.org.uk> wrote:

> On Mer, 2003-08-06 at 18:23, Rob van Nieuwkerk wrote:
> > Stephen C. Tweedie made a fix (see below) for it in May.
> > It has been in the Alan's -ac series since then and it works fine.
> 
> Certainly seems to be fine and it is a real bug. There is another unfixed
> one of the same form with tty drivers too

Hi Alan,

How does this other bug present itself ?
I use both console and serial port output in my readonly CF
application.  And I don't have any writes to the CF anymore after
fixing the FIFO bug.

	greetings,
	Rob van Nieuwkerk
