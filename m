Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262429AbTEIKed (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 May 2003 06:34:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262431AbTEIKed
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 May 2003 06:34:33 -0400
Received: from carisma.slowglass.com ([195.224.96.167]:62476 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id S262429AbTEIKec (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 May 2003 06:34:32 -0400
Date: Fri, 9 May 2003 11:47:09 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Chuck Ebbert <76306.1226@compuserve.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: The disappearing sys_call_table export.
Message-ID: <20030509114709.A18684@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Chuck Ebbert <76306.1226@compuserve.com>,
	linux-kernel <linux-kernel@vger.kernel.org>,
	Alan Cox <alan@lxorguk.ukuu.org.uk>
References: <200305090513_MC3-1-3814-65C8@compuserve.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <200305090513_MC3-1-3814-65C8@compuserve.com>; from 76306.1226@compuserve.com on Fri, May 09, 2003 at 05:11:57AM -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 09, 2003 at 05:11:57AM -0400, Chuck Ebbert wrote:
>   So it's not 'layer a filesystem over another one' it's 'mount an
> instance of a filesystem over another instance' then.  And this means
> it gets mounted twice with two different mountpoint names, right?

it gets mounted twice with either the same or different mountpoint
names.  You can have multiple mountspoints with the same path, only
the topmost one will be seen by userland.

