Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263345AbVGANz0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263345AbVGANz0 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Jul 2005 09:55:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263344AbVGANzZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Jul 2005 09:55:25 -0400
Received: from web25802.mail.ukl.yahoo.com ([217.12.10.187]:39061 "HELO
	web25802.mail.ukl.yahoo.com") by vger.kernel.org with SMTP
	id S263346AbVGANzQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Jul 2005 09:55:16 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.fr;
  h=Message-ID:Received:Date:From:Subject:To:MIME-Version:Content-Type:Content-Transfer-Encoding;
  b=LWH57OD73FS5EPzZBXCG1aB7HtWvaEvq1W8T0K6sVIoT3EL8296+FPy47J1IhQZ86cf3MO1IKJr2hA9ZyzvdK7JQ1I1mfrmCnB14nh7+WGUA/h5OMYDwMZba0jsDgPIE0e02XuZ9YPCOBeY5viLekMh6sXCnNd5sjWB7zjka7zw=  ;
Message-ID: <20050701135514.54702.qmail@web25802.mail.ukl.yahoo.com>
Date: Fri, 1 Jul 2005 15:55:14 +0200 (CEST)
From: moreau francis <francis_moreau2000@yahoo.fr>
Subject: [UHCI] weird macro in "uhci_hub_control"
To: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I'm surely missing obvious thing but I can't get an answer.
In "uhci_hub_control", there are a lot of uses of OK macro, defined in the same
file. This macro set up "len" local, and do a break. Why does it setup "len"
since it's not used in the function. Moreover it's pretty ugly to hide "break"
keyword in a macro, isn't it ?

Thanks

      Francis



	

	
		
___________________________________________________________________________ 
Appel audio GRATUIT partout dans le monde avec le nouveau Yahoo! Messenger 
Téléchargez cette version sur http://fr.messenger.yahoo.com
