Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129324AbRADDdR>; Wed, 3 Jan 2001 22:33:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132116AbRADDdH>; Wed, 3 Jan 2001 22:33:07 -0500
Received: from Cantor.suse.de ([194.112.123.193]:51975 "HELO Cantor.suse.de")
	by vger.kernel.org with SMTP id <S129324AbRADDc7>;
	Wed, 3 Jan 2001 22:32:59 -0500
Date: Thu, 4 Jan 2001 04:32:44 +0100
From: Andi Kleen <ak@suse.de>
To: David Huggins-Daines <dhd@eradicator.org>
Cc: linux-kernel@vger.kernel.org, Dan Aloni <karrde@callisto.yi.org>
Subject: Re: [RFC] prevention of syscalls from writable segments, breaking bug exploits
Message-ID: <20010104043244.A16413@gruyere.muc.suse.de>
In-Reply-To: <Pine.LNX.4.21.0101032259550.20246-100000@callisto.yi.org> <87hf3gj94q.fsf@monolith.cepstral.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <87hf3gj94q.fsf@monolith.cepstral.com>; from dhd@eradicator.org on Wed, Jan 03, 2001 at 10:20:37PM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 03, 2001 at 10:20:37PM -0500, David Huggins-Daines wrote:
> Dan Aloni <karrde@callisto.yi.org> writes:
> 
> > This preliminary, small patch prevents execution of system calls which
> > were executed from a writable segment.
> 
> How does signal return work, then?

Newer glibc sets a sa_restorer.

-Andi

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
