Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263519AbTDYJUZ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Apr 2003 05:20:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263521AbTDYJUZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Apr 2003 05:20:25 -0400
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([213.105.254.86]:8583
	"EHLO lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S263519AbTDYJUZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Apr 2003 05:20:25 -0400
Subject: re: interrupting connect(), EINTR, EINPROGRESS, EALREADY, and so on
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Dan Kegel <dank@kegel.com>
Cc: david.madore@ens.fr,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <3EA8CA5E.7030102@kegel.com>
References: <3EA8CA5E.7030102@kegel.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1051259624.5459.4.camel@dhcp22.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 25 Apr 2003 09:33:45 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Gwe, 2003-04-25 at 06:40, Dan Kegel wrote:
> David Madore wrote:
>  > http://www.eleves.ens.fr:8080/home/madore/computers/connect-intr.html
> Interesting.
> 
> I'd suggest bringing this up on the austin-group-l list,
> see http://www.opengroup.org/austin/lists.html

Linux is perhaps a little friendlier but it isnt clear. The socket api
drafts have an even more fun bug. For some protocols "bind" is a
blocking operation but the API was written by someone who never
considered this

