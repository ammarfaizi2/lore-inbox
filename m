Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316258AbSE3ER7>; Thu, 30 May 2002 00:17:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316261AbSE3ER6>; Thu, 30 May 2002 00:17:58 -0400
Received: from to-velocet.redhat.com ([216.138.202.10]:19954 "EHLO
	touchme.toronto.redhat.com") by vger.kernel.org with ESMTP
	id <S316258AbSE3ER5>; Thu, 30 May 2002 00:17:57 -0400
Date: Thu, 30 May 2002 00:17:57 -0400
From: Benjamin LaHaise <bcrl@redhat.com>
To: "Todd R. Eigenschink" <todd@tekinteractive.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: interrupt count (/proc/stat) change in 2.4.19-pre9
Message-ID: <20020530001757.A26137@redhat.com>
In-Reply-To: <15605.42173.758778.408074@rtfm.ofc.tekinteractive.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 29, 2002 at 11:04:13PM -0500, Todd R. Eigenschink wrote:
> Is it trying to induce some sort of intentional overflow in the
> interrupt count, or is there some other big-picture change that
> requires this?  I see the comment from the BK changeset, but I still
> don't understand the purpose.

It's a brown paper bag.  By making the counts 9 digits long, the bug in 
the old code that the patch fixed was triggered.

		-ben
