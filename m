Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284664AbRLMSjK>; Thu, 13 Dec 2001 13:39:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284753AbRLMSjC>; Thu, 13 Dec 2001 13:39:02 -0500
Received: from mailgw2a.lmco.com ([192.91.147.7]:50962 "EHLO mailgw2a.lmco.com")
	by vger.kernel.org with ESMTP id <S284664AbRLMSi5>;
	Thu, 13 Dec 2001 13:38:57 -0500
Content-return: allowed
Date: Thu, 13 Dec 2001 13:36:09 -0500
From: "Needham, Douglas" <douglas.needham@lmco.com>
Subject: kernel performance issues 2.4.7 -> 2.4.17-pre8
To: linux-kernel@vger.kernel.org
Message-id: <1B7FCD9C07D3D4118FC500508BDF42E80457DFB1@emss09m02.ems.lmco.com>
MIME-version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-type: multipart/mixed; boundary="Boundary_(ID_P3ZYIzyVMJlsW0uSWfqMlQ)"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This message is in MIME format. Since your mail reader does not understand
this format, some or all of this message may not be legible.

--Boundary_(ID_P3ZYIzyVMJlsW0uSWfqMlQ)
Content-type: text/plain; charset=ISO-8859-1
Content-transfer-encoding: 7BIT

OBJECTIVE: 

	I wanted to create an automated performance test battery that I
could run against new kernels as a validation for the environments that I
work with.

What I did:

	I decided I would run dbench and tbench with increasing number of
instances from 1 to 10. I would also run Bonnie starting with the base
memory size, and then run it with twice the memory size and finally four
times the memory size of the machine. I tested various kernel
configurations. I have to have ipsec for the kernels I run, so all of these
kernels have the ipsec patches in them. However, since the Red Hat kernel
does not include the freeswan patches I brought down ipsec in all my test
instances. 
	

Hardware used: 

	A HP desktop with a Pentium III-500, 128M memory, 20 Gig harddrive.
The hardware was the same for all tests. 

Software used: 

	Dbench, tbench and bonnie.
	These tests were run immediately upon startup of the machine, so all
processes where the same for all tests. 
	(This is an attempt to keep as many conditions the same as possible
while changing out only the kernel)


Kernels: 

	In the results table the first column is the directory that I used
to store my results. The kernels that match these directories are : 

Test-2.4.07-10-(timestamp)   == Red Hat 7.2 base kernel
Test-2.4.09-13-(timestamp)   == Red Hat 7.2 update kernel
Test-2.4.10ipsec-(timestamp) == kernel.org 2.4.10 with freeswan patches
Test-2.4.14ipsec-(timestamp) == kernel.org 2.4.14 with freeswan patches
Test-2.4.15ipsec-(timestamp) == kernel.org 2.4.15 with freeswan patches (
and the umount pacth)
Test-2.4.16ipaup-(timestamp) == kernel.org 2.4.16 with freeswan, aa, and
preemptable patches 
Test-2.4.16ipsec-(timestamp) == kernel.org 2.4.16 with freeswan patches 
Test-2.4.16ipsp-(timestamp)  == kernel.org 2.4.16 with freeswan, and
preemptable patches 
Test-2.4.17-pre8-(timestamp) == kernel.org 2.4.16 with freeswan, and 17-pre8
patches 


What I found: 

	Overall I discovered that the Red Hat modified kernel beat the stock
kernel hands down in throughput.  Both the base Red Hat 7.2 kernel and the
7.2 update kernel (2.4.7-9, 2.4.9-13 respectively) had far better throughput
than the .10, .15, .14, .16, and .17-pre8 kernels. 

Results: 

	I have attached the results to this email as a gzipped html
attachment. It is simple a HTML TABLE that describes all of my results.


What I am looking for:

	Guidance. Could someone tell me what if anything I am doing wrong
with my tests, or point me in the direction to look where I can begin
understanding why the throughput performance dropped?



Thanks,


Doug


  <<result_12-13.html.gz>> 


--Boundary_(ID_P3ZYIzyVMJlsW0uSWfqMlQ)
Content-type: application/octet-stream; name=result_12-13.html.gz
Content-disposition: attachment; filename=result_12-13.html.gz
Content-transfer-encoding: BASE64

H4sICB6lGDwAA3Jlc3VsdF8xMi0xMy5odG1sALRd0a4cR259D5B/mJcASRC3i6wi
qyqwBcTZAHlIgMDYII+CVrqwhbUlQdJis/n6sK40VaXVncvTF/QCXgP2qD097C4e
Hh4efvf7f/nhP/7t8oe371/dvf+eLi9+ef3Tm+9f3r35ePf+8ufXrz7+/L2klJ59
9/sf7a9/f3b54937N3e/XD7effh49+q7b+0f2T++vHz7y4d3L958T+nZ5dUf7t68
/Pn+Ex/sEh9/vrx78f7XC12O40Lp8uCf+Xj2z8izyw9v37x5fbf/mbv/ff3h4+s3
P11+vfv17fu/XD68/r+7f7rw5R9v/JsXb15dyo1/+/m/+e39fY+/fvf552hpfF/7
j37DRzlS/YbSN5wSEaf+PDWS73748dn407/b/lCR9IzpYO758p8/fPvh7uWF3r1/
+/LD+PD9Z//2b/7q0+nopfbrp9n5dDmEy/XD2flwPrjwvHR5/NPUjq5tXluca8uR
udXrp9W9ttQ8P12dT+uhTecP2JxP14O1zLvszqfp6LXPu6TkfFyOlNZP6MRyfJVW
ChhL+1FKaQ0NZjlKKwoG056qxlnAYFI/cpOCBjNbeKShwbR3hzKjwSxHznAs7cW0
743G8n/ev75/+T8dO3/6+PLv/+GwY+f6v1dv39z9s/1dqffLH+2Sl0vvB1/+7l//
679vXvPHuz9/uup+pcvX1+ysn69pX1ofv+b1e762s/kXO6btjP7lL+v6n6/JKZf8
+Zrcjux9zxev5r3/dHfr3kvW+vmaKkfFrvn49yTKQp+veanovbsxsrcsOkZM13u3
Q6JFxIiENV1jxEePiVGv13uvdiaExCjXec1L8+IOxkjafD578Z8l8D3K19/TTqEU
EqOS+xYj8Jl3YiTU5Rqj6j1LYIwMesh6j76+9zMIhvg59ZRvIhiLVxNFEUy2Y7hU
FMGwIZgKQxg5qC2Y4UGYetTcOp71WidCs54eqRTCs17vFU96mpKgWc9Suz20MIKp
R5Z8AsHYc6F4LLknNJb2e1flhiOYnjoKR2k8JxWGo3rkyifgKMt6TrxgysFp3aUX
zHKQ1nAIYy94dHqUlq5pfDyBIRBGBnr7dM0shwRBmJl2tHhwAzx6ObOs9Oj8njCE
kS1GFJMeZaVH8uAGmh4lX6Eru7AITY+pX69ZNQrCWL1zjVEPgjCaJnTtzYMbYIxq
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

--Boundary_(ID_P3ZYIzyVMJlsW0uSWfqMlQ)--
