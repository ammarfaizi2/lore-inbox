Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263688AbTDNUjZ (for <rfc822;willy@w.ods.org>); Mon, 14 Apr 2003 16:39:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263957AbTDNUjZ (for <rfc822;linux-kernel-outgoing>);
	Mon, 14 Apr 2003 16:39:25 -0400
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([213.105.254.86]:34235
	"EHLO lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S263688AbTDNUjW (for <rfc822;linux-kernel@vger.kernel.org>); Mon, 14 Apr 2003 16:39:22 -0400
Subject: Re: Memory mapped files question
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Bryan Shumsky <bzs@via.com>
Cc: "Perez-Gonzalez, Inaky" <inaky.perez-gonzalez@intel.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <004301c302bd$ed548680$fe64a8c0@webserver>
References: <A46BBDB345A7D5118EC90002A5072C780BEBAD8D@orsmsx116.jf.intel.com>
	 <004301c302bd$ed548680$fe64a8c0@webserver>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1050349977.26521.2.camel@dhcp22.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 14 Apr 2003 20:53:00 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Llu, 2003-04-14 at 20:42, Bryan Shumsky wrote:
> Rewriting all of our code to manually handle the flushing is a MAJOR
> undertaking, so I was hoping there might be some sneaky solution you could
> come up with.  Any ideas?

Create a thread that does msync's every so often. Its that simple

