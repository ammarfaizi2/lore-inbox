Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932215AbVIENeE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932215AbVIENeE (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 Sep 2005 09:34:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932198AbVIENeE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Sep 2005 09:34:04 -0400
Received: from rproxy.gmail.com ([64.233.170.194]:54798 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932215AbVIENeC convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Sep 2005 09:34:02 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=OVQl+0quq+71mnxWgJAqX3Q6rJTrREl0iZ2xaslR8lUpxk8ATLQ+CLvjQyAj+j2MMPXT0VRNOiQwjBJP1PH3A4hgX8lfyb80xdvZFLtALqlsYMmPdFSofiGoQVUq7eBwbV8WElCrwieqhZvPJ/JuRFcvtF5sXKqAgDfuUh/gC+Y=
Message-ID: <907421f905090506337ba17394@mail.gmail.com>
Date: Mon, 5 Sep 2005 21:33:59 +0800
From: mandy london <laborious.bee@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: the difference between irq save and the irq disable ?
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

in my mind, irq save only store the conditions of that time ,  and the
following code can access the shared region and change it ,so modify 
irq  states .

while , disable irq  keeps the states of interrupt unchangable .

but , I have no knowlege of the difference between code in irq save
and irq restore and  in irq disable and irq enable ?

whethe the former can be interrupted and the later not ? only this ?
