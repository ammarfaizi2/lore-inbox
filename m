Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932145AbWBYWim@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932145AbWBYWim (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 25 Feb 2006 17:38:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932167AbWBYWim
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 25 Feb 2006 17:38:42 -0500
Received: from mx1.redhat.com ([66.187.233.31]:46249 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S932145AbWBYWim (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 25 Feb 2006 17:38:42 -0500
Date: Sat, 25 Feb 2006 17:38:15 -0500 (EST)
From: Rik van Riel <riel@redhat.com>
X-X-Sender: riel@cuia.boston.redhat.com
To: Peter Foldiak <Peter.Foldiak@st-andrews.ac.uk>
cc: Maciej Soltysiak <solt2@dns.toxicfilms.tv>,
       Jesper Juhl <jesper.juhl@gmail.com>,
       Jan Engelhardt <jengelh@linux01.gwdg.de>, linux-kernel@vger.kernel.org,
       reiserfs-list@namesys.com, Hans Reiser <reiser@namesys.com>
Subject: Re: creating live virtual files by concatenation
In-Reply-To: <4400DA93.9080901@st-andrews.ac.uk>
Message-ID: <Pine.LNX.4.63.0602251736340.13659@cuia.boston.redhat.com>
References: <1271316508.20060225153749@dns.toxicfilms.tv>
 <9a8748490602250735l6161a96dte2805b772a89a436@mail.gmail.com>
 <612760535.20060225181521@dns.toxicfilms.tv> <Pine.LNX.4.63.0602251339320.13659@cuia.boston.redhat.com>
 <9a8748490602251052p3e56334ei755c9ce2100e03c@mail.gmail.com>
 <1391154345.20060225203352@dns.toxicfilms.tv> <4400DA93.9080901@st-andrews.ac.uk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 25 Feb 2006, Peter Foldiak wrote:

> "sub-file" corresponding to a key-range. Writing a chapter should change the
> book that the chapter is part of. That is what would make it really valuable.
> Of course it would have all sorts of implications (e.g. for metadata for each
> part) that need to be thought about, but it could be done properly, I think.

What happens if you read the first 10kB of a file,
and one of the "chapters" behind your read cursor
grows?

Do you read part of the same data again when you
continue reading?

Does the read cursor automatically advance?

Your idea changes the way userspace expects files
to behave...

-- 
All Rights Reversed
