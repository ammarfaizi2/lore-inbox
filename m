Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264356AbTDKNDJ (for <rfc822;willy@w.ods.org>); Fri, 11 Apr 2003 09:03:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264357AbTDKNDJ (for <rfc822;linux-kernel-outgoing>);
	Fri, 11 Apr 2003 09:03:09 -0400
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([213.105.254.86]:33190
	"EHLO lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S264356AbTDKNDI (for <rfc822;linux-kernel@vger.kernel.org>); Fri, 11 Apr 2003 09:03:08 -0400
Subject: RE: kernel support for non-English user messages
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Riley Williams <Riley@Williams.Name>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <BKEGKPICNAKILKJKMHCAIEBJCGAA.Riley@Williams.Name>
References: <BKEGKPICNAKILKJKMHCAIEBJCGAA.Riley@Williams.Name>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1050063394.14153.16.camel@dhcp22.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 11 Apr 2003 13:16:35 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2003-04-11 at 10:21, Riley Williams wrote:
>  1. If the printk() messages are internationalised, we are going to
>     see log extracts posted here in various languages, including some
>     that the relevant maintainers don't understand. To stand any
>     realistic chance of dealing with the resultant bug reports, we
>     need to include the message code in the report so we can just
>     feed the various reports through a tool that translates them into
>     our preferred language.

Providing the viewer is translating the originals always exist. Indeed
you can do

	LANG=es view-logs
	LANG=ru view-logs
	...

You can have sysadmins with no common language("not a recommended
configuration" ;))

You are right about needing to log parameters, but given a log line
of the form

%s: went up in flames\n\0eth0\0\0

that can be handled by the log viewer

