Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261629AbVGZKXp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261629AbVGZKXp (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Jul 2005 06:23:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261666AbVGZKXp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Jul 2005 06:23:45 -0400
Received: from web25805.mail.ukl.yahoo.com ([217.12.10.190]:22633 "HELO
	web25805.mail.ukl.yahoo.com") by vger.kernel.org with SMTP
	id S261629AbVGZKXo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Jul 2005 06:23:44 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.fr;
  h=Message-ID:Received:Date:From:Subject:To:MIME-Version:Content-Type:Content-Transfer-Encoding;
  b=lxEB77jbAXOHotO7iqK5Rs5V63V9cYWDnPQFz+1LT6T65xzusNE1zZ370pF4aOZ0ON3DHyLm0D9fciukRveesvdhnUI4erYSUh2r0Em6GUoNzNPmG5b6nC9/2KXKAUSMITKHIhx4wQuUSE4hCXtQGWYsrorlxc1ovd8MwSefP08=  ;
Message-ID: <20050726102340.44709.qmail@web25805.mail.ukl.yahoo.com>
Date: Tue, 26 Jul 2005 12:23:40 +0200 (CEST)
From: moreau francis <francis_moreau2000@yahoo.fr>
Subject: [INPUT] simple question on driver initialisation.
To: linux-kernel@vger.kernel.org, vojtech@suse.cz
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I'm currently developping a very simple driver for a pinpad by using
Input module. I'm using Event handler to pass events from pinpad to userland.
In this simple case, I'm wondering if I really need to initialise
"phys" field in in "input_dev" struct before calling "input_register_device".
What is this field for ?

Thanks for your answers,

         Francis.


	

	
		
___________________________________________________________________________ 
Appel audio GRATUIT partout dans le monde avec le nouveau Yahoo! Messenger 
Téléchargez cette version sur http://fr.messenger.yahoo.com
