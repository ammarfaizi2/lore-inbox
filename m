Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314164AbSDMA6J>; Fri, 12 Apr 2002 20:58:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314165AbSDMA6I>; Fri, 12 Apr 2002 20:58:08 -0400
Received: from c5cust8.starstream.net ([206.170.161.8]:27012 "HELO
	10cust182.starstream.net") by vger.kernel.org with SMTP
	id <S314164AbSDMA6I>; Fri, 12 Apr 2002 20:58:08 -0400
Date: Fri, 12 Apr 2002 17:58:05 -0700
From: Ted Deppner <ted@psyber.com>
To: Oleg Drokin <green@namesys.com>
Cc: ted@psyber.com, linux-kernel@vger.kernel.org,
        Hans Reiser <reiser@namesys.com>
Subject: Re: New IDE code and DMA failures
Message-ID: <20020413005805.GA17025@dondra.ofc.psyber.com>
Reply-To: Ted Deppner <ted@psyber.com>
Mail-Followup-To: Oleg Drokin <green@namesys.com>, ted@psyber.com,
	linux-kernel@vger.kernel.org, Hans Reiser <reiser@namesys.com>
In-Reply-To: <200204111236.g3BCaMX10247@Port.imtp.ilyichevsk.odessa.ua> <20020411130544.GA8163@dondra.ofc.psyber.com> <20020411181027.A1870@namesys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 11, 2002 at 06:10:27PM +0400, Oleg Drokin wrote:
> We are interested in such a damaged partitions that makes current reiserfsck
> to segfault or to incorrectly repair FS (incorrectly in the meaning that
> subsequent reiserfsck run finds more errors)
> Is this the case with you?

Subsequent runs of reiserfsck are no longer finding new errors.  There
were several cases where --rebuild-tree segfaulted reiserfsck -- HOWEVER
this was before I got the DMA errors ironed out.

Now that the DMA errors are taken care of, I've not been able to get
reiserfsck to behave oddly.

-- 
Ted Deppner
http://www.psyber.com/~ted/
