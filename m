Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263423AbTJBRs4 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Oct 2003 13:48:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263422AbTJBRs4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Oct 2003 13:48:56 -0400
Received: from cpc3-hitc2-5-0-cust152.lutn.cable.ntl.com ([81.99.82.152]:27019
	"EHLO zog.reactivated.net") by vger.kernel.org with ESMTP
	id S263423AbTJBRsy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Oct 2003 13:48:54 -0400
Message-ID: <3F7C6530.3040109@reactivated.net>
Date: Thu, 02 Oct 2003 18:49:36 +0100
From: Daniel Drake <dan@reactivated.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.5b) Gecko/20030905 Thunderbird/0.2
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: torvalds@osdl.org
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] (2.6.0-test6) DocBook: Remove reference to linux-via
Content-Type: multipart/mixed;
 boundary="------------030800020809050002090406"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------030800020809050002090406
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Hi,

In the DocBook documentation for the via-audio driver, there is an address for a linux-via mailing list for reporting bugs.

I tried sending a mail to the list and it bounced back (user unknown).

I found an archive of this list on MARC, but as you can see it hasn't been active for about a year:
http://marc.theaimsgroup.com/?l=linux-via&r=1&w=2

Looks like that list is gone. Here's a patch to remove it from the documentation.

Daniel.

--------------030800020809050002090406
Content-Type: text/plain;
 name="docbook-via-audio-list-gone.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="docbook-via-audio-list-gone.patch"

--- linux-2.6.0-test6/Documentation/DocBook/via-audio.tmpl	2003-09-28 11:34:13.000000000 +0100
+++ linux/Documentation/DocBook/via-audio.tmpl	2003-10-02 18:44:00.456146624 +0100
@@ -65,16 +65,6 @@
   <para>
   	This driver supports any Linux kernel version after 2.4.10.
   </para>
-  <para>
-	Please send bug reports to the mailing list <email>linux-via@gtf.org</email>.
-	To subscribe, e-mail <email>majordomo@gtf.org</email> with
-  </para>
-  <programlisting>
-	subscribe linux-via
-  </programlisting>
-  <para>
-	in the body of the message.
-  </para>
   </chapter>
   
   <chapter id="install">

--------------030800020809050002090406--

