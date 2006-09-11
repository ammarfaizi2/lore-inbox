Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932100AbWIKJl4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932100AbWIKJl4 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Sep 2006 05:41:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932164AbWIKJlz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Sep 2006 05:41:55 -0400
Received: from ecfrec.frec.bull.fr ([129.183.4.8]:4075 "EHLO
	ecfrec.frec.bull.fr") by vger.kernel.org with ESMTP id S932100AbWIKJlz convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Sep 2006 05:41:55 -0400
Date: Mon, 11 Sep 2006 11:41:43 +0200
From: =?ISO-8859-1?Q?S=E9bastien_Dugu=E9?= <sebastien.dugue@bull.net>
To: linux-kernel@vger.kernel.org
Cc: linux-aio@kvack.org, drepper@redhat.com, suparna@in.ibm.com,
       pbadari@us.ibm.com, zach.brown@oracle.com, hch@infradead.org,
       johnpol@2ka.mipt.ru, davem@davemloft.net, sebastien.dugue@bull.net
Subject: [PATCH AIO 0/2] AIO completion notification and listio support
Message-ID: <20060911114143.0af786ce@frecb000686>
X-Mailer: Sylpheed-Claws 2.3.1 (GTK+ 2.8.18; i486-pc-linux-gnu)
Mime-Version: 1.0
X-MIMETrack: Itemize by SMTP Server on ECN002/FR/BULL(Release 5.0.12  |February 13, 2003) at
 11/09/2006 11:47:28,
	Serialize by Router on ECN002/FR/BULL(Release 5.0.12  |February 13, 2003) at
 11/09/2006 11:47:31,
	Serialize complete at 11/09/2006 11:47:31
Content-Transfer-Encoding: 8BIT
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


  Here is a rework of the patches adding support for AIO completion
notification as well as listio support.

  Notification is now modeled after the posix-timer code as per Ulrich
suggestion.

  Sébastien.


-----------------------------------------------------

  Sébastien Dugué                BULL/FREC:B1-247
  phone: (+33) 476 29 77 70      Bullcom: 229-7770

  mailto:sebastien.dugue@bull.net

  Linux POSIX AIO: http://www.bullopensource.org/posix
                   http://sourceforge.net/projects/paiol
  
-----------------------------------------------------
