Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315106AbSDWIcI>; Tue, 23 Apr 2002 04:32:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315109AbSDWIcH>; Tue, 23 Apr 2002 04:32:07 -0400
Received: from relay.dera.gov.uk ([192.5.29.49]:45317 "HELO relay.dera.gov.uk")
	by vger.kernel.org with SMTP id <S315106AbSDWIcG>;
	Tue, 23 Apr 2002 04:32:06 -0400
Subject: Re: XFS in the main kernel
From: Tony Gale <gale@taz.dstl.gov.uk>
To: Wichert Akkerman <wichert@wiggy.net>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20020422234419.GQ2470@dstl.gov.uk>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.4 
Date: 23 Apr 2002 09:31:58 +0100
Message-Id: <1019550718.17000.1.camel@syntax.dstl.gov.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2002-04-23 at 00:44, Wichert Akkerman wrote:
> If memory serves me corrrectly one of the problems was that rename(2)
> returned an error in rare cases that should not be possible (might have
> been ENOENT even though both we have verified in advance that can't be
> true).
> 

That may be related to the accented character handling bug that appeared
for a short period of time, which was fixed a couple of months ago.

-tony


