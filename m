Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265413AbTFWLmf (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Jun 2003 07:42:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265479AbTFWLmf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Jun 2003 07:42:35 -0400
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([213.105.254.86]:5328
	"EHLO lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S265413AbTFWLme (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Jun 2003 07:42:34 -0400
Subject: Re: patch for common networking error messages
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: "David S. Miller" <davem@redhat.com>
Cc: girouard@us.ibm.com, stekloff@us.ibm.com, janiceg@us.ibm.com,
       jgarzik@pobox.com, kenistonj@us.ibm.com, lkessler@us.ibm.com,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       netdev@oss.sgi.com, niv@us.ibm.com
In-Reply-To: <20030622.174641.74727201.davem@redhat.com>
References: <OFC2446DB8.6D4DA3ED-ON85256D47.007C79EE@us.ibm.com>
	 <20030616.155533.63022973.davem@redhat.com>
	 <1056199013.25974.27.camel@dhcp22.swansea.linux.org.uk>
	 <20030622.174641.74727201.davem@redhat.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1056369251.13529.17.camel@dhcp22.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 23 Jun 2003 12:54:12 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Llu, 2003-06-23 at 01:46, David S. Miller wrote:
>    From: Alan Cox <alan@lxorguk.ukuu.org.uk>
>    Date: 21 Jun 2003 13:36:54 +0100
>    
>    Standardising strings is a real help for end users,
> 
> I agree.  But my objections are in the context of doing this
> inside the kernel, where such things do not belong.

Standardising strings for end users in the kernel is also good
because it both saves space and makes things more consistent for
the poor human wondering what blew up.

Standardising them for programs to parse is not a good idea

