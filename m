Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269633AbRHMBSp>; Sun, 12 Aug 2001 21:18:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269639AbRHMBSe>; Sun, 12 Aug 2001 21:18:34 -0400
Received: from schmee.sfgoth.com ([63.205.85.133]:11534 "EHLO
	schmee.sfgoth.com") by vger.kernel.org with ESMTP
	id <S269633AbRHMBSW> convert rfc822-to-8bit; Sun, 12 Aug 2001 21:18:22 -0400
Date: Sun, 12 Aug 2001 18:18:30 -0700
From: Mitchell Blank Jr <mitch@sfgoth.com>
To: =?iso-8859-1?Q?Renaud_Gu=E9rin?= <rguerin@free.fr>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.4.8 breaks ATM
Message-ID: <20010812181830.B93564@sfgoth.com>
In-Reply-To: <E15Vuaq-0000BF-00@saturne.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT
X-Mailer: Mutt 1.0i
In-Reply-To: <E15Vuaq-0000BF-00@saturne.local>; from rguerin@free.fr on Sun, Aug 12, 2001 at 02:43:47PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Renaud Guérin wrote:
> The following part of the 2.4.8 patch seems to be a typo (">>" looks more 
> logical than ">" if vci_bit is a bitfield), and broke ATM for me:

Yes, the patch is 100% wrong and should be reverted.  It had been sent to
the ATM maintainers and was rejected, but someone else must have submitted
it upstream since it magically appeared in the mainstream kernel.  It's
already been reverted in both 2.4.9pre1 and 2.4.8ac1.

-Mitch
