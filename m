Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S275399AbRJFR7a>; Sat, 6 Oct 2001 13:59:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S275420AbRJFR7U>; Sat, 6 Oct 2001 13:59:20 -0400
Received: from shed.alex.org.uk ([195.224.53.219]:60596 "HELO shed.alex.org.uk")
	by vger.kernel.org with SMTP id <S275399AbRJFR7I>;
	Sat, 6 Oct 2001 13:59:08 -0400
Date: Sat, 06 Oct 2001 18:59:34 +0100
From: Alex Bligh - linux-kernel <linux-kernel@alex.org.uk>
Reply-To: Alex Bligh - linux-kernel <linux-kernel@alex.org.uk>
To: Mikulas Patocka <mikulas@artax.karlin.mff.cuni.cz>,
        Rik van Riel <riel@conectiva.com.br>
Cc: Krzysztof Rusocki <kszysiu@main.braxis.co.uk>, linux-xfs@oss.sgi.com,
        linux-kernel@vger.kernel.org,
        Alex Bligh - linux-kernel <linux-kernel@alex.org.uk>
Subject: Re: %u-order allocation failed
Message-ID: <462829506.1002394773@[195.224.237.69]>
In-Reply-To: <Pine.LNX.3.96.1011006164044.29342B-200000@artax.karlin.mff.cuni.cz>
In-Reply-To: <Pine.LNX.3.96.1011006164044.29342B-200000@artax.karlin.mff.cuni
 .cz>
X-Mailer: Mulberry/2.1.0 (Win32)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



--On Saturday, 06 October, 2001 4:44 PM +0200 Mikulas Patocka 
<mikulas@artax.karlin.mff.cuni.cz> wrote:

> Here goes the fix. (note that I didn't try to compile it so there may be
> bugs, but you see the point).

(seems to replace high order allocations by vmalloc)

& how does vmalloc allocate physically (as opposed to virtually)
contiguous memory; can't clearly recall it being IRQ safe either
(for GFP_ATOMIC).

--
Alex Bligh
