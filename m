Return-Path: <linux-kernel-owner+w=401wt.eu-S932083AbXAFTIf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932083AbXAFTIf (ORCPT <rfc822;w@1wt.eu>);
	Sat, 6 Jan 2007 14:08:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932082AbXAFTIf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 6 Jan 2007 14:08:35 -0500
Received: from pfepc.post.tele.dk ([195.41.46.237]:42458 "EHLO
	pfepc.post.tele.dk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932086AbXAFTIe (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 6 Jan 2007 14:08:34 -0500
Subject: Re: libata error handling
From: Kasper Sandberg <lkml@metanurb.dk>
To: Robert Hancock <hancockr@shaw.ca>
Cc: LKML Mailinglist <linux-kernel@vger.kernel.org>, jgarzik@pobox.com,
       alan@lxorguk.ukuu.org.uk
In-Reply-To: <459FF1F8.1050306@shaw.ca>
References: <fa.pdj7pJD9C08bRZatFINV1hz1oyA@ifi.uio.no>
	 <459FE8BE.7070208@shaw.ca> <1168109874.1512.11.camel@localhost>
	 <459FF1F8.1050306@shaw.ca>
Content-Type: text/plain
Date: Sat, 06 Jan 2007 20:08:32 +0100
Message-Id: <1168110512.1512.13.camel@localhost>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.0 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2007-01-06 at 13:01 -0600, Robert Hancock wrote:
> Kasper Sandberg wrote:
> > On Sat, 2007-01-06 at 12:21 -0600, Robert Hancock wrote:
> >> Kasper Sandberg wrote:
> >>> i have heard that libata has much better error handling (this is what
> >>> made me try it), and from initial observations, that appears to be very
> >>> true, however, im wondering, is there something i can do to get
> >>> extremely verbose information from libata? for example if it corrects
> >>> errors? cause i'd really like to know if it still happens, and if i
> >>> perhaps get corruption as before, even though not severe.
> >> Any errors, timeouts or retries would be showing up in dmesg..
> > how sure can i be of this? is it 100% sure that i have not encountered
> > this error then?
> 
> Pretty sure, I'm quite certain libata never does any silent error recovery..
okay, i suppose i face two possibilities then:
1: libata drivers are simply better, and the error does not occur
because of driver bugs in the old ide drivers
2: it hasnt happened to me on libata yet (though this is also abit
weird, as it has now ran far longer than were previously required to hit
the errors)
> 

