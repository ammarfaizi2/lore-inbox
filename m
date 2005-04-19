Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261633AbVDSTbU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261633AbVDSTbU (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 19 Apr 2005 15:31:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261631AbVDSTbU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Apr 2005 15:31:20 -0400
Received: from mail-ext.curl.com ([66.228.88.132]:25874 "HELO
	mail-ext.curl.com") by vger.kernel.org with SMTP id S261635AbVDST1D
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Apr 2005 15:27:03 -0400
To: "Theodore Ts'o" <tytso@mit.edu>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Fortuna
References: <20050414141538.3651.qmail@science.horizon.com> <20050414133336.GA16977@thunk.org>
From: "Patrick J. LoPresti" <patl@curl.com>
Date: 19 Apr 2005 15:27:02 -0400
In-Reply-To: <20050414133336.GA16977@thunk.org>
Message-ID: <s5gis2iwos9.fsf@egghead.curl.com>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.3
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Theodore Ts'o <tytso@mit.edu> writes:

> With a properly set up set of init scripts, /dev/random is
> initialized with seed material for all but the initial boot

What about CD-ROM based distros (e.g., Knoppix), where every boot is
the initial boot?

> (and even that problem can be solved by having the distribution's
> install scripts set up /var/lib/urandom/random-seed after installing
> the system).

Could you elaborate?  How should Knoppix seed its /dev/urandom?

Would reading 256 bits from /dev/random and writing them to
/dev/urandom do the job?

 - Pat
