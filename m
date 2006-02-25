Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932610AbWBYIcN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932610AbWBYIcN (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 25 Feb 2006 03:32:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932618AbWBYIcN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 25 Feb 2006 03:32:13 -0500
Received: from a222036.upc-a.chello.nl ([62.163.222.36]:1676 "EHLO
	laptopd505.fenrus.org") by vger.kernel.org with ESMTP
	id S932610AbWBYIcM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 25 Feb 2006 03:32:12 -0500
Subject: Re: Patch to reorder functions in the vmlinux to a defined order
From: Arjan van de Ven <arjan@linux.intel.com>
To: Folkert van Heusden <folkert@vanheusden.com>
Cc: linux-kernel@vger.kernel.org, "Eric W. Biederman" <ebiederm@xmission.com>
In-Reply-To: <20060225021152.GI1637@vanheusden.com>
References: <1140700758.4672.51.camel@laptopd505.fenrus.org>
	 <43FF26A8.9070600@keyaccess.nl> <m17j7kda52.fsf@ebiederm.dsl.xmission.com>
	 <200602241748.39949.ak@suse.de> <m1wtfkbihh.fsf@ebiederm.dsl.xmission.com>
	 <20060225021152.GI1637@vanheusden.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Sat, 25 Feb 2006 09:32:05 +0100
Message-Id: <1140856326.2991.1.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2006-02-25 at 03:11 +0100, Folkert van Heusden wrote:
> What about shuffeling the pages at runtime? Or are cachelines wired to
> physical pages?

remember that kernel pages are 2Mb in size, not 4Kb.
That makes it rather highly impractical ;)

(even 4Kb has many practical issues since most functions are smaller
than 4Kb by far)
