Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268354AbTCFVpO>; Thu, 6 Mar 2003 16:45:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268402AbTCFVpO>; Thu, 6 Mar 2003 16:45:14 -0500
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([213.105.254.86]:28072
	"EHLO irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S268354AbTCFVpN>; Thu, 6 Mar 2003 16:45:13 -0500
Subject: Re: Disabling ATAPI retry?
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: kelleycook@wideopenwest.com
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <3e67c49b.7c12.1804289383@wideopenwest.com>
References: <3e67c49b.7c12.1804289383@wideopenwest.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1046991672.17715.134.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.1 (1.2.1-4) 
Date: 06 Mar 2003 23:01:12 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2003-03-06 at 20:58, kelleycook@wideopenwest.com wrote:
> Is there a boot parameter or a runtime command that can tell
> the linux IDE driver not to automatically retry on error.

There isn't. You can always build a kernel set not to, but even then it
takes the drive firmware a sizeable time to retry a block. If its an IBM
you might want to try the ibm tools on them if you can get them. They 
seem to have vanished from the face of the earth when IBM dumped its disk
business 

