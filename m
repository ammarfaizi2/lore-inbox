Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129324AbRADDWG>; Wed, 3 Jan 2001 22:22:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132116AbRADDVz>; Wed, 3 Jan 2001 22:21:55 -0500
Received: from zeus.kernel.org ([209.10.41.242]:25099 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id <S129324AbRADDVl>;
	Wed, 3 Jan 2001 22:21:41 -0500
To: linux-kernel@vger.kernel.org
Cc: Dan Aloni <karrde@callisto.yi.org>
Subject: Re: [RFC] prevention of syscalls from writable segments, breaking bug exploits
In-Reply-To: <Pine.LNX.4.21.0101032259550.20246-100000@callisto.yi.org>
From: David Huggins-Daines <dhd@eradicator.org>
Organization: None worth mentioning
Date: 03 Jan 2001 22:20:37 -0500
In-Reply-To: Dan Aloni's message of "Wed, 03 Jan 2001 21:14:59 GMT"
Message-ID: <87hf3gj94q.fsf@monolith.cepstral.com>
User-Agent: Gnus/5.0803 (Gnus v5.8.3) Emacs/20.7
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dan Aloni <karrde@callisto.yi.org> writes:

> This preliminary, small patch prevents execution of system calls which
> were executed from a writable segment.

How does signal return work, then?

-- 
David Huggins-Daines		-		dhd@eradicator.org
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
